{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation rec {
  pname = "git-worktree-runner";
  version = "2.6.0";

  src = fetchFromGitHub {
    owner = "coderabbitai";
    repo = "git-worktree-runner";
    rev = "v2.6.0";
    sha256 = "sha256-ltM/QM5sGYJdUbmZQHx7TZa829zG3s0Eh9ZHmZYNWiE=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -r adapters/ lib/ templates/ $out
    cp bin/gtr bin/git-gtr $out/bin
    chmod +x $out/bin/gtr $out/bin/git-gtr

    cp -r completions/ $out
    runHook postInstall
  '';

  meta = with lib; {
    description = "Bash-based Git worktree manager with editor and AI tool integration";
    homepage = "https://github.com/coderabbitai/git-worktree-runner";
    license = licenses.asl20;
    mainProgram = "git-gtr";
    platforms = platforms.unix;
  };
}
