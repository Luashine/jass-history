# Jass History

This tracks the development of Jass scripts between game versions without naming the game name. Simple, OK?

The repository is cursed, expect commits to be rebased, petted, fed lead-contaminated nuts, removed, travel back in time... Magic is not for everyone. Consult your doctor before use.

Only tags are stable references.

Scripts are there https://github.com/Luashine/wc3-jass-history-scripts

## How to filter non-empty commits

For Github, append `?w=1` or `&w=1` to the end of URL to skip whitespace changes.

```
$ git log --oneline --invert-grep --grep EMPTY
(tag: Reforged-v1.33.0.19203)
(tag: Reforged-v1.32.7.15572)
(tag: Reforged-v1.32.10.19202)
(tag: Reforged-v1.32.10.18820)
(tag: Reforged-v1.32.0.14411)
(tag: TFT-v1.31.1.12173)
(tag: TFT-v1.30.4.11274)
(tag: TFT-v1.30.1.10211)
(tag: TFT-v1.29.2.9231)
(tag: TFT-v1.29.0.8803)
(tag: TFT-v1.28.2.7395)
(tag: TFT-v1.24a-ru)
(tag: TFT-v1.18a-ru)
(tag: TFT-v1.17a-ru)
(tag: TFT-v1.15-ru)
(tag: TFT-v1.13b-ru)
(tag: TFT-v1.11-ru)
(tag: TFT-v1.07-ru)
(tag: Beta-TFT-v308)
(tag: Beta-TFT-v306)
(tag: Beta-TFT-v305)
(tag: Beta-TFT-v304)
(tag: Beta-TFT-v302)
(tag: Beta-TFT-v300)
(tag: ROC-v1.11-ru)
(tag: ROC-v1.05-ru)
(tag: ROC-v1.04-ru)
(tag: ROC-v1.03-ru)
(tag: ROC-v1.01b-ru)
(tag: Beta-ROC-v1.30)
(tag: Beta-ROC-v1.20)
(tag: Beta-ROC-v1.10)
(tag: Beta-ROC-v1.03)
(tag: Beta-ROC-v1.00)
(tag: baseline) // this is my tag for an "empty" repo before versioning
```

## My notes

### LF vs CRLF

`Beta-TFT-v306/Scripts/u03x04.ai` and `Beta-TFT-v307/Scripts/u03x04.ai` had LF line endings.

