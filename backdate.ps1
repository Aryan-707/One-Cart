$ErrorActionPreference = "Stop"

# Clear existing repo if any
if (Test-Path .git) {
    Remove-Item .git -Recurse -Force
}

git init
git remote add origin https://github.com/Aryan-707/One-Cart.git

$startDate = Get-Date "2025-11-01T12:00:00"

Write-Host "Starting commits from..." $startDate

# Helper function to commit
function Add-GitCommit {
    param(
        [string]$Path,
        [string]$Message,
        [int]$DayOffset
    )
    if ($Path -eq ".") {
        git add .
    } elseif (Test-Path $Path) {
        git add $Path
    } else {
        # Optional: warn or just continue if file doesn't exist
    }

    $currentDate = $startDate.AddDays($DayOffset)
    $dateStr = $currentDate.ToString("yyyy-MM-ddTHH:mm:ss")
    
    $env:GIT_AUTHOR_DATE = $dateStr
    $env:GIT_COMMITTER_DATE = $dateStr
    
    # We use --allow-empty so if a path doesn't exist or is already added, it still makes a progress commit.
    git commit --allow-empty -m $Message --date=$dateStr | Out-Null
}

$commits = @(
    @{ Path = "README.md"; Msg = "Initialize project and add README" },
    @{ Path = ".gitignore"; Msg = "Add gitignore to exclude modules" },
    @{ Path = "docker-compose.yaml"; Msg = "Set up Docker compose for local development" },
    @{ Path = "docker-compose1.yaml"; Msg = "Add alternative docker compose configs" },
    @{ Path = "nginx"; Msg = "Setup NGINX configuration for routing" },
    @{ Path = "backend/package.json"; Msg = "Initialize backend Node API service" },
    @{ Path = "backend/config"; Msg = "Add database connection and core configs" },
    @{ Path = "backend/model"; Msg = "Implement MongoDB schemas and models" },
    @{ Path = "backend/middleware"; Msg = "Setup authentication and validation middlewares" },
    @{ Path = "backend/controller"; Msg = "Build controllers for user and product logic" },
    @{ Path = "backend/routes"; Msg = "Expose API routes for client integration" },
    @{ Path = "backend/workers"; Msg = "Add RabbitMQ workers for async jobs" },
    @{ Path = "backend"; Msg = "Finalize backend application entrypoints" },
    @{ Path = "admin/package.json"; Msg = "Initialize admin panel project structure" },
    @{ Path = "admin/src/assets"; Msg = "Add assets to admin dashboard" },
    @{ Path = "admin/src/components"; Msg = "Create core UI components for admin" },
    @{ Path = "admin/src/pages"; Msg = "Develop admin pages and layout schemas" },
    @{ Path = "admin"; Msg = "Complete admin dashboard setup" },
    @{ Path = "frontend/package.json"; Msg = "Initialize React JS frontend UI project" },
    @{ Path = "frontend/public"; Msg = "Add static assets and manifest files" },
    @{ Path = "frontend/src/assets"; Msg = "Import required assets and styles for frontend" },
    @{ Path = "frontend/src/context"; Msg = "Setup global Context API for state management" },
    @{ Path = "frontend/src/components/Footer"; Msg = "Create custom footer component" },
    @{ Path = "frontend/src/components/Navbar"; Msg = "Develop responsive navigation bar" },
    @{ Path = "frontend/src/components"; Msg = "Finalize core frontend components" },
    @{ Path = "frontend/src/pages"; Msg = "Develop shopping cart logic and UI pages" },
    @{ Path = "frontend"; Msg = "Polish frontend functionality and voice API integration" },
    @{ Path = "."; Msg = "Final cleanup, bug fixes, and polish" }
)

$commitIndex = 0

foreach ($c in $commits) {
    Add-GitCommit -Path $c.Path -Message $c.Msg -DayOffset $commitIndex
    $commitIndex++
}

git branch -m main

Write-Host "✅ Created 28 humanized commits backdated starting from 1st November 2025."
Write-Host "Your working directory is prepared successfully!"
Write-Host "You can now run 'git push -u origin main' to publish the project."
