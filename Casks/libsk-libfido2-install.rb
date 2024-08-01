cask "libsk-libfido2-install" do
  desc "libsk-libfido2 for MacOS Yubikey support for SSH"
  homepage "https://github.com/MichaelRoosz/homebrew-ssh/"
  version "9.7p1_build1"
  
  url "https://raw.githubusercontent.com/MichaelRoosz/homebrew-ssh/main/etc/install-libsk-libfido2-v1.1.4.zsh"
  sha256 "8baaea786500f65bdf8f1641f467b812697b18dd0a6f6c48e7b97301e77b9dd8"
  
  depends_on arch: [:intel, :arm64]
  depends_on formula: "michaelroosz/ssh/libsk-libfido2"
  depends_on formula: "theseal/ssh-askpass/ssh-askpass"

  postflight do
    system_command "/bin/zsh", args: ["#{staged_path}/install-libsk-libfido2-v1.1.4.zsh"], sudo: true
    system_command "/bin/zsh", args: ["-c", "/bin/launchctl unload /Library/LaunchAgents/com.mroosz.ssh_env_vars.plist || true"], sudo: false
    system_command "/bin/zsh", args: ["-c", "/bin/launchctl load /Library/LaunchAgents/com.mroosz.ssh_env_vars.plist || true"], sudo: false
    system_command "/bin/zsh", args: ["-c", "echo 'export SSH_SK_PROVIDER=/usr/local/lib/libsk-libfido2.dylib' >> ~/.zshrc || true"], sudo: false
  end

  uninstall_postflight do
    system_command "/bin/zsh", args: ["-c", "rm /usr/local/lib/libsk-libfido2.dylib || true"], sudo: true
    system_command "/bin/zsh", args: ["-c", "/bin/launchctl unload /Library/LaunchAgents/com.mroosz.ssh_env_vars.plist || true"], sudo: false
    system_command "/bin/zsh", args: ["-c", "rm /Library/LaunchAgents/com.mroosz.ssh_env_vars.plist || true"], sudo: true
  end

end
