# Git Synchronize

_Remote git repository syncing._

[![Development Status](https://img.shields.io/badge/development--status-pre--alpha-orange?style=flat-square)](https://pypi.org/classifiers)

Git SYN is a command line extension for synchronizing git remote repositories.

## Compiling

```sh
make
```

## Installation

```sh
make install
```

## Usage

```sh
git syn -h
Usage: git-syn [option] ... [repository] ...

Options:
  -h, --help            Show this message and quit
  -d, --debug           Output debugging messages
  -q, --quiet           Only output fatal error messages
  -v, --verbose         Be verbose (show external command output)
  --version             Print version and exit

Arguments:
  repository            Path to a git repository
```

## License

SPDX-License-Identifier: [GPL-2.0-or-later](COPYING)

## Reference

- [How to integrate new subcommands](https://git.kernel.org/pub/scm/git/git.git/plain/Documentation/howto/new-command.txt)
- [/srv : Data for services provided by this system](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s17.html)

## See Also

- [Git Large File Storage (LFS)](https://git-lfs.github.com)

- [GitLab Repository Mirroring](https://docs.gitlab.com/ee/user/project/repository/repository_mirroring.html)

