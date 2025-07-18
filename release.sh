tag_name="v1.0"

git add .github/workflows/release.yml

git commit --amend --no-edit
git tag -f $tag_name
git push origin $tag_name -f