# Prereqs

* You must have a local Ruby environment that can run the tests
  via `rake`.
* You must have the [GitHub CLI tool (gh)](https://cli.github.com/)
  installed, in your path, and logged into an account that can
  make GitHub releases on the repo.
* Your environment also must have `bash`, `git`, `perl`, and `sed`
  available.

# How to release

* Review open issues and PRs to see if anything needs to be addressed
  before release.
* Create a branch e.g. `horgh/release` and switch to it.
  * `main` is protected.
* Set the release version and release date in `CHANGELOG.md`. Be sure
  the version follows [Semantic Versioning](https://semver.org/).
* Commit these changes.
* Run `dev-bin/release.sh`.
* Verify the release on the GitHub Releases page.
* If everything goes well, the authorized releasers will receive an email
  to review the pending deployment. If you are an authorized releaser,
  you will need to approve the release deployment run. If you are not,
  you will have to wait for an authorized releaser to do so.
* Double check it looks okay at https://rubygems.org/gems/minfraud and
  https://www.rubydoc.info/gems/minfraud.
* Make a PR and get it merged.
