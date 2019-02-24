workflow "Build and test" {
  on = "push"
  resolves = ["Check TeX"]
}

action "Build image" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  args = "build -t texlive-full ."
}

action "Check TeX" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Build image"]
  args = "run --rm texlive-full tex -version"
}
