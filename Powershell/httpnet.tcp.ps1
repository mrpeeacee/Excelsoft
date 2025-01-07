Set-ItemProperty "IIS:\sites\Default Web Site\MOESLSSupplementaryAPI" -name enabledProtocols -value "http,net.tcp"

Set-ItemProperty 'IIS:\sites\Default Web Site\MOE" -name preloadEnabled -Value "True"