FROM ocaml/opam:alpine-ocaml-4.12@sha256:97d4da55048befbda12adc18765b049a9eb53a878bcce58dbfecb06f363273e8

USER root
RUN sed -i 's-/home/opam:/sbin/nologin-/home/opam:/bin/bash-' /etc/passwd
USER opam

RUN opam install sedlex dune base merlin ocamlformat ppx_jane ocaml-lsp-server
RUN sudo apk add git neovim inotify-tools
RUN mkdir -p ~/.cache/nvim

RUN bash -c "source ~/.profile; dune build"
RUN bash -c "source ~/.profile; dune test"