
#!/bin/bash
set -e

ls  ~/.gnupg/ ~/.ssh/ >/dev/null

eval $(op signin mcquaid.1password.com mike@mikemcquaid.com)
if ! which -s op
then
  brew cask install onepassword-cli
fi

op get document xrenp5t62jem7nz6arxaswsica > ~/.ssh/id_ed25519
op get document zagw7lmcsbhszhkfpxeacdyhza > ~/.ssh/id_rsa
op get document 3sjbzdhzfzcr3o52qrojwjgjjq > ~/.gnupg/mike@mikemcquaid.com.private.gpg-key

chmod 600 ~/.ssh/id_ed25519 \
          ~/.ssh/id_rsa \
          ~/.gnupg/mike@mikemcquaid.com.private.gpg-key
chmod 700 ~/.gnupg
gpg --import ~/.gnupg/mike@mikemcquaid.com.public.gpg-key \
             ~/.gnupg/mike@mikemcquaid.com.private.gpg-key
