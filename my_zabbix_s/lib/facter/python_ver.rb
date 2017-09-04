Facter.add(:python_ver) do
  setcode do
    a = Facter::Core::Execution.exec("/bin/python --version 2>&1")
    a.empty? ? 'false' : a
  end
end