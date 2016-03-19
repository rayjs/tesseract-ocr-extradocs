# nn file format #

nn files describe a neural network made up of input nodes, output nodes and hidden nodes.

The code in tesseract that reads these files is in neural\_networks/runtime/neural\_net.h and neural\_networks/runtime/neuron.h

## Layout ##

### Header ###
```
1 byte of signature
1 byte of auto_encode (unsigned int)
1 byte of number of nodes ("neurons") (unsigned int)
1 byte of number of input nodes (unsigned int)
1 byte of number of output nodes (unsigned int)
```

### Output connections ###
```
for each neuron
  1 byte of fan_out count
  for each fan_out
    1 byte of node number that is connected (unsigned int)
```

### Input connections ###
```
for each neuron
  1 byte of float 'bias' (float)
  1 byte of weight_count (unsigned int)
  for each weight_count
    1 byte of weight (float)
```

### Statistics ###
```
1 byte of input mean values (float)
1 byte of input standard deviation values (float)
1 byte of input minimum values (float)
1 byte of input maximum values (float)
```

## Notes ##

All integers are stored in little endian order.

I wrote a simple script to read the file: [interrogate\_nn.tcl](https://code.google.com/p/tesseract-ocr-extradocs/source/browse/interrogate_nn.tcl)

The current code in tesseract for reading .nn files doesn't appear to be very portable; it assumes little endian machines where integers and floats are 32 bits, and I think the float representation is machine specific too. Someone should redo it after reading http://commandcenter.blogspot.com/2012/04/byte-order-fallacy.html.