# Resume

[![Open in Dev Containers](https://img.shields.io/static/v1?label=Dev%20Containers&message=Open&color=blue)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/suasuasuasuasua/resume-template)

## Getting Started

> Give it a try! And if you want to continue your own resume, click _use this
template_ near the top right on the repo.

If you already have VS Code and Docker installed, you can click the badge above
or
[here](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/suasuasuasuasua/resume-template)
to get started. Clicking these links will cause VS Code to automatically install
the Dev Containers extension if needed, clone the source code into a container
volume, and spin up a dev container for use.

## Idea

`texlive` is notoriously difficult to set up properly between choosing the
distribution, the package scheme, and even finding the proper word processing
program. If you're like most people, you'll just end up using something like
[overleaf](https://www.overleaf.com) or Microsoft Word because it just works out
of the box. Fair enough, I have to give Overleaf credit because the web
interface is pretty, yourfiles can be accessed anywhere (with an internet
connection), and there isbuilt-in LSP support in the web editor. However, my
problem with overleaf is thefact that it only works online and forces you to
upgrade to a premium plan for what I consider basic features.

In this vein, I am using [`devenv`](https://devenv.sh) to write my resumes for
four reasons: 1) I want version control through `git` so that I can track
changes and rollback if I mess anything up. 2) I want my development
collaborative through [GitHub](https://github.com) or [Live
Share](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare).
3) I want a deterministic development environment across any machine, which is
where `nix` and `docker` comes in. And lastly 4) I want this development
experience to be __free__.

`devenv` uses `nix` under the hood as the package manager, so if you already
have `nix` installed on your computer, go ahead and install `devenv` and
`direnv` to automatically build and load the development shell. This way, you
don't need to use the `devcontainer` (which could be a performance bottleneck).
Otherwise, the `devcontainer` is a very convenient way to isolate the project
dependencies and ensure that you have everything setup properly.

Before finding out about `devenv`, I had a
[`Dockerfile`](https://github.com/suasuasuasuasua/resume-template/blob/5ae4f3b4f9c8e1c347826ebec5c3602efc384b0d/.devcontainer/Dockerfile)
that defined all the `texlive` dependencies in a container manually. As you can
guess, that took me way too long to figure out and was very annoying to set up
properly! I probably spent at least 3-4 hours just figuring out how to install
`texlive` in a way that was _minimal_. With the new `devenv` setup, all it took
was enabling the language and adding some package names. Yep, that's it! No
running some weird [archaic instructions](https://tug.org/texlive/) or messing
around with weird container idiosyncrasies. The best part is that I can use a
text editor like Visual Studio Code with my [`vim`
integration](https://github.com/VSCodeVim/Vim) to write my documents seamlessly.

```nix
{
  # https://devenv.sh/languages/
  languages.texlive = {
    enable = true;
    base = pkgs.texliveSmall;
    packages = [
      "latexmk"
      "texcount"
      "xcharter"
      "xstring"
      "fontaxes"
      "enumitem"
      "titlesec"
    ];
  };
}
```

You can see the complete configuration under `devenv.nix`

### `typst`

As an aside, I've also included a setup file for [`typst`](https://typst.app)
which is vying to become the modern `texlive`. The syntax is much cleaner,
doesn't require antiquated and obscure commands to write _simple_ symbols, and
the underlying engine is much faster at compiling the documents. It's pretty
similar to `markdown` actually but is just supercharged for the writer and
scientist.

### An Aside

You don't have to use this template just for the resume! The dev environment
should work for anything from homework, reports, personal documents, etc. The
main idea behind this repo is learning $LaTeX$ and `typst` and using `devenv`.

## Template

See [the LaTeX template](template.tex) that my resume is based off.
