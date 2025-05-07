This bash script automates the setup of a development environment on a Linux machine by:

- Installing Homebrew (the Linuxbrew fork)
- Configuring your shell to load Homebrew’s environment
- Installing GNU build tools (build-essential)
- Updating your package lists
- Installing GCC via Homebrew
- Installing and configuring asdf-vm for version management
- Adding the Node.js plugin to asdf, installing the latest Node.js, and setting a default version
- Enabling Corepack and setting up pnpm as your package manager
- Handling any fallback steps in case pnpm isn’t immediately available

How to run the script
Save the script
Copy the contents below into a file named setup.sh in your home directory (or wherever you prefer).

Make it executable

``` bash
chmod +x setup.sh
```

Run the script

If you’re already in the directory where setup.sh lives:

``` bash
./setup.sh
```

Or, without changing permissions:

```bash
bash setup.sh
```

Enter your password
Whenever the script invokes sudo, you’ll be prompted for your password—enter it and press Enter to continue.

Reload your shell
At the end it sources your .bashrc, but if you open a new terminal or run:

``` bash
source ~/.bashrc
```

you’ll be sure all changes take effect.

Verify everything installed correctly

```bash
brew --version
asdf --version
node --version
pnpm --version
```

Each command should print its version number. If so, your development environment is ready to go!