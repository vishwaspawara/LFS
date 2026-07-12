# Git & GitHub Setup

## Generate an SSH key

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

## Copy the public key

```bash
cat ~/.ssh/id_ed25519.pub
```

Add the key to your GitHub account.

## Verify SSH authentication

```bash
ssh -T git@github.com
```

## Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

## Clone or initialize repository

```bash
git clone git@github.com:<username>/LFS.git
```

or

```bash
git init
git remote add origin git@github.com:<username>/LFS.git
```

## First commit

```bash
git add .
git commit -m "Initial LFS setup"
git push -u origin main
```
