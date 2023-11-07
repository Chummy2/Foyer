# Define variables
$piHost = "192.168.68.168"  # Replace with your Raspberry Pi's IP address
$username = "pi"  # Replace with your Raspberry Pi username

# Create an SSH session
$session = New-PSSession -HostName $piHost -UserName $username -SSHTransport

# Enter the SSH session
Enter-PSSession -Session $session
