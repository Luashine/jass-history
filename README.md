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

## CascView and CDN IDs

CascView 3.0 can access arbitrary online storages from the CDN if you know the ID. Use Task Manager to see if it's downloading, because the progress bar doesn't work or tell you it's slowly downloading something.

`wine CascView.exe /online 'C:\home/MYUSERNAME/temp/cachePath-for-CASC/*w3*eu*2aa787736e88e43f6ace0a4ac897fc8f'`

CDN IDs:

- 1.30.0
   - `w3t.cfg:1.30.0.9655|6a3d539e4cc9d474c07a3fefde4a36ca|version-w3t-24451.bmime`
   - `w3.cfg:1.30.0.9900|2aa787736e88e43f6ace0a4ac897fc8f|version-w3-34563.bmime`
- 1.30.1
   - `w3t.cfg:1.30.1.10085|3694964441a01beb8b475576e9c39da0|version-w3t-41859.bmime`
   - `w3.cfg:1.30.1.10211|38f31eb67143d03da05854bfb559ed42|version-w3-45187.bmime`
- 1.30.2
   - `w3t.cfg:1.30.2.10369|5ab4cace6abb8453fb3422e7123ee474|version-w3t-50435.bmime`
   - `w3.cfg:1.30.2.11113|cb849e73984c98f37ee8f1760356709c|version-w3-71491.bmime`
- 1.30.3
   - `w3t.cfg:1.30.3.11145|c1d20a79d9f890d7c7674e1c3bda313a|version-w3t-74115.bmime`
   - `w3.cfg:1.30.3.11235|aab047a72e72fb9016192edbf0662b5e|version-w3-74435.bmime`
- 1.30.4
   - `w3.cfg:1.30.4.11274|7c45731c22f6bf4ff30035ab9d905745|version-w3-77187.bmime`
- 1.31.0
   - `w3t.cfg:1.31.0.11889|189880a364a0594dba2164c7c7074ec0|version-w3t-101762.bmime`
   - `w3.cfg:1.31.0.12071|cc2dbb838eb5156585bc71cf9951ee65|version-w3-101763.bmime`

etc. I didn't bother anymore

## My notes

### Script to diff folders vs manual list

As you can see I stopped making my own sorting script (call me stupid) and thought it's a one time task to do it manually. Instead here's a script to compare entries for completeness.

```shell
cd "war3extract" && \
find . -maxdepth 1 -type d | sed 's|\./||g' | sort > find.txt && \
sort ../version-list-sorted.txt > manual.txt && \
diff manual.txt find.txt;
rm -i manual.txt find.txt
```

### Patches not part of change list

ROC 1.10, ROC 1.11. Maybe they'll got their own branch to not ruin the history.

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

I scrapped this entire section, lets start again. I will be repeating myself, I have written in detail in my test-maps repo and [on Hive about this](https://www.hiveworkshop.com/threads/list-of-official-patches-for-warcraft-3.322919/#js-XFUniqueId77).

The last real ROC version is 1.06. The gold TFT release did not add update patches for ROC, but the game code was 1.07, so that's what ROC shows. Also TFT/ROC 1.07 use both original and expansion MPQs for game data.

-> ROC 1.07 does not exist

1.10 was an online-only patch for TFT 1.07 players. It did add ROC patch MPQs, but without Expansion MPQs the game was not able to load, 1.10 ROC standalone does not exist. However I will add its files (from war3patch.mpq)
to the repo for completeness.

This means realistically we are jumping like this:

- ROC 1.06
- TFT Betas
- TFT 1.07
- TFT 1.10 (and a ripped patch file from here for "ROC 1.10" for TFT owners)
- TFT 1.11 (and standalone ROC 1.11 diverges from here)

Apparently the ROC versions still shared updates to common.j, but I'm not going to go down this path and assume TFT-only from this point onwards.

