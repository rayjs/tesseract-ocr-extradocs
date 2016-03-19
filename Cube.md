Cube is an alternative recognition mode for Tesseract. It is slower than the original recognition engine, but often produces better results.

# Using cube #

The recognition mode for tesseract is controlled by the configuration variable `tessedit_ocr_engine_mode`.

| **tessedit\_ocr\_engine\_mode** | **Description** |
|:--------------------------------|:----------------|
| 0                               | Use original Tesseract recognition engine |
| 1                               | Use cube recognition engine |
| 2                               | Use both engines, automatically choosing whichever appears to give better results |

# Cube training #

No tools for cube training have been released.

All existing cube trainings have the following files:

  * lang.cube.fold
  * lang.cube.lm
  * lang.cube.nn
  * lang.cube.params
  * lang.cube.size
  * lang.cube.word-freq

Some also have these files:

  * lang.cube.bigrams
  * lang.cube-word-dawg
  * lang.cube-unicharset
  * lang.tesseract\_cube.nn

## cube.fold ##

Plain text.

Specifies which characters are likely to be mistaken for one another. See [classifier\_base.h](http://code.google.com/p/tesseract-ocr/source/browse/trunk/cube/classifier_base.h).

Each line is formatted:
```
o0O
```

Each character on the line can be easily mistaken for another character on the same line.

## cube.lm ##

Plain text.

Categorises characters. `lm` stands for language model. See [tess\_lang\_model.h](http://code.google.com/p/tesseract-ocr/source/browse/trunk/cube/tess_lang_model.h).

Each line is formatted:
```
type=abc
```

The above would add characters `a`, `b` and `c` to category `type`.

## cube.nn ##

[nn file](nnFileFormat.md).

Unknown exactly. Contains various weightings and connections arranged in a "neural network". See [conv\_net\_classifier.h](http://code.google.com/p/tesseract-ocr/source/browse/trunk/cube/conv_net_classifier.h).

## cube.params ##

Plain text.

Parameters specific to cube recognition. See [tuning\_params.h](http://code.google.com/p/tesseract-ocr/source/browse/trunk/cube/tuning_params.h).

Each line is formatted:
```
parameter=value
```

## cube.size ##

Plain text.

Describes the dimensions of sets of 2 characters (bigrams). See [word\_size\_model.h](http://code.google.com/p/tesseract-ocr/source/browse/trunk/cube/word_size_model.h).

Each line is formatted:
```
fontname	char_id	char	width	height	char2_id	char2	delta_top	width2	height2
```

delta\_top is the difference between the top of both characters.

## cube.word-freq ##

Plain text.

Describes the frequency of words. See [word\_unigrams.h](http://code.google.com/p/tesseract-ocr/source/browse/trunk/cube/word_unigrams.h).

Each line is formatted:
```
word	number
```

The second column is a number representing the cost (e.g. penalty) for a word to appear. The lower the number, the more likely the word.

Every word has the first character capitalised. A few words (such as TheOnion) are made of multiple words, each capitalised, but not separated by spaces.

## cube.bigrams ##

Plain text.

Describes the likelihood of two characters being adjacent. See [char\_bigrams.h](http://code.google.com/p/tesseract-ocr/source/browse/trunk/cube/char_bigrams.h).

Each line is formatted:
```
    123	002d 002a
```

The first column is a number representing the number of times the combination appears in a sample. The higher the number, the more likely the combination. The second and third numbers are character codes in hex (UCS-4).

## cube-word-dawg ##

DAWG file.

Uses unicharset from cube-unicharset.

## cube-unicharset ##

Plain text.

Identical format to .unicharset for traditional training, can use either v2 or v3 format. See [unicharset(5)](http://tesseract-ocr.googlecode.com/svn/trunk/doc/unicharset.5.html).

Some trainings have different values to their .unicharset, so this one should be used for cube tools that need a unicharset value, e.g. dawg2wordlist.

## tesseract\_cube.nn ##

[nn file](nnFileFormat.md).

Appears to be a dummy or otherwise very skeletal cube neural net file. It isn't used by tesseract, and is very small (less than 1k in the few examples we have; either 660B or 996B).