# How to notes

## New versions

Manually add one version:

1. Grab build config from either:
	- <https://github.com/mdX7/ngdp_data/>
	- <https://github.com/mdX7/ribbit_data>
2. `.\CascView.exe /online "D:\Work-BUILDNUMBER\*w3t*us*ae5...4fd"`
	- CascView may be picky about having a separate folder each. It's best to have a new folder per build to avoid weird errors.
3. Go to scripts/ folder
4. Extract & wait `war3.w3mod:scripts` (make sure the extract path is correct for the current build number)
5. Extract `war3.w3mod:_balance\custom_v0.w3mod:scripts`
6. Extract `war3.w3mod:_balance\melee_v0.w3mod:scripts`
7. Put the extracted files in `/jass-history/war3extract/<tag name>`
8. Commit
9. Add tag name to `version-list-sorted.txt`
10. Copy-paste & replace folder contents into `/jass-history/timeline/`
11. Commit as `version: <tag name>`
12. `git tag <tag name>`
13. git push && git push --tags
	- this way the diff commit only contains the `timeline/` changes

## Downstream projects

1. Update jassdoc
2. For common.j + blizzard.j changes: Update Notepad++ syntax highlighter
