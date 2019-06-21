import subprocess as sp


def repo_exists(repo_url):
  git = sp.run(["git", "ls-remote", repo_url], stdout=sp.PIPE, stderr=sp.PIPE)
  return git.returncode == 0


def clone(repo_name, out_dir):
  orgs = "plexinc", "sztomi"
  for org in orgs:
    url = f"git@github.com:{org}/{repo_name}.git"
    if repo_exists(url):
      sp.run(["git", "clone", "--recursive", url, out_dir])


if __name__ == "__main__":
  from argparse import ArgumentParser
  parser = ArgumentParser()
  parser.add_argument("repo_name")
  parser.add_argument("out_dir", nargs="?", default=None)
  args = parser.parse_args()
  clone(args.repo_name, args.repo_name or args.out_dir)
