choco install postgresql --version=16.8.0 -y
# Set file path
$filePath = "C:\Program Files\PostgreSQL\16\data\pg_hba.conf"
# Define the text to find and the replacement text
$oldText = "scram-sha-256"
$newText = "trust"
# Read file content
$content = Get-Content -Path $filePath -Raw
# Replace text
$updatedContent = $content -replace [regex]::Escape($oldText), $newText
# Write updated content back to file
Set-Content -Path $filePath -Value $updatedContent -Encoding UTF8
 & "C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -c "ALTER USER postgres WITH PASSWORD 'postgres123';"
$newText = "scram-sha-256"
$oldText = "trust"
# Read file content
$content = Get-Content -Path $filePath -Raw
# Replace text
$updatedContent = $content -replace [regex]::Escape($oldText), $newText
# Write updated content back to file
Set-Content -Path $filePath -Value $updatedContent -Encoding UTF8

# Set proper permissions for PostgreSQL service account
$filePath = "C:\Program Files\PostgreSQL\16\data\pg_hba.conf"
$acl = Get-Acl $filePath
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\NETWORK SERVICE","FullControl","Allow")
$acl.SetAccessRule($accessRule)
$accessRule2 = New-Object System.Security.AccessControl.FileSystemAccessRule("postgres","FullControl","Allow")
$acl.SetAccessRule($accessRule2)
Set-Acl $filePath $acl
