from rever.activity import activity

# Check that we are on the master branch
branch=$(git branch --show-current)
if branch.strip() != "master":
  raise Exception("You must be on the master branch to release.")
# and that it is up to date with origin/master
git fetch https://github.com/echemdb/vue-echemdb.git
git reset FETCH_HEAD
git diff --exit-code
git diff --cached --exit-code

@activity
def publish():
  yarn
  yarn build
  yarn publish --new-version $VERSION

$PROJECT = 'vue-echemdb'

$ACTIVITIES = [
    'version_bump',
    'changelog',
    'tag',
    'push_tag',
    'ghrelease',
    'publish',
]

$VERSION_BUMP_PATTERNS = [
    ('package.json', r'"version":', r'"version": "$VERSION",'),
]

$CHANGELOG_FILENAME = 'ChangeLog'
$CHANGELOG_TEMPLATE = 'TEMPLATE.rst'
$CHANGELOG_NEWS = 'news'
$CHANGELOG_CATEGORIES = ('Added', 'Changed', 'Removed', 'Fixed')
$PUSH_TAG_REMOTE = 'git@github.com:echemdb/vue-echemdb.git'

$GITHUB_ORG = 'echemdb'
$GITHUB_REPO = 'vue-echemdb'
