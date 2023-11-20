# Jass History

This tracks the development of Jass scripts between game versions without naming the game name. Simple, OK?

The repository is cursed, expect commits to be rebased, petted, fed lead-contaminated nuts, removed, travel back in time... Magic is not for everyone. Consult your doctor before use.

Only tags are stable references.

Scripts are there https://github.com/Luashine/wc3-jass-history-scripts

## How to contribute?

Find me the missing Warcraft 3 versions, pretty please with sugar on top and an air kiss. *I'll be completely and fully satisfied* with a first version for each release, like 1.30.0 and 1.31.0.

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

### Missing patch 1.10 ROC/TFT

https://wowpedia.fandom.com/wiki/Warcraft_III/Patch_1.10

And then 1.11 seems to be a minor patch. So probably all of the script changes appeared in 1.10, but the common version and patch everyone had is 1.11.

The Russian TFT CD installs straight to 1.11.

Firstrun70 found this, labelled "TFT-en" and "TFT-ru" (MadSerg also had the ru file):

- `War3TFT_110_English_Not official.exe` aka `WarCraft3_X_110.exe`, `5338206` bytes (5.1 MiB)
   - `https://www.playground.ru/warcraft_3/file/warcraft_3_v1_10_english-852342` it's here under the X name
   -
- md5 89e76fb2befcb95b2f269111b1111ef5
- sha256 7a0c61cccc36cd90504b9629b6636d95d93b6b48be820c7aa066f2ad1cce4865

- `War3TFT_110_Russian_Not official.exe` aka `WarCraft3_X_110_ru.exe`, `5584253` bytes (5.3 MiB)
   - `https://www.playground.ru/warcraft_3/file/warcraft_3_v1_10_russian-852343` it's there under the X name
      - some people say it didn't work under Windows XP
- md5 220e8ba301d450614c5f18869986b7a6
- sha256 20ffe6508d8c3281289540d1ffe0cc89f91f3d9f41cc59681fcee359eb12ad81


### LF vs CRLF

`Beta-TFT-v306/Scripts/u03x04.ai` and `Beta-TFT-v307/Scripts/u03x04.ai` had LF line endings.

### Correct ordering of ROC and TFT Beta

`Scripts/Cheats.j` Line 12:

`  constant string   bj_DEBUG_CHAT_TELEPORT2     = "ttt"`

- was readded in TFT 1.07
- did not exist in TFT Beta v300 etc
- was added in ROC 1.11 (or 1.10?)

Therefore the better ordering of versions is:

- ROC 1.06
- TFT BETA, all
- ROC 1.07 (???)
- ROC 1.11
- TFT 1.07
- TFT 1.11

See if this makes sense?

**Another example:**

- Added in TFT v1.07, ROC 1.11:
- Did not exist in TFT Beta v300-308


```
//===========================================================================
// This seemingly useless function is used to trick the trigger editor into
// externalizing arbitrary strings.  Especially useful for storing externalized
// string references in variables.
//
function StringIdentity takes string theString returns string
    return theString
endfunction
```

