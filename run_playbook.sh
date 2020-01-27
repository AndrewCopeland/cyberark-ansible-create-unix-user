source env.sh
# download the cyberark collection
ansible-galaxy collection install cyberark.pas
# get the certificate from conjur
openssl s_client -showcerts -connect conjur-master:443 < /dev/null 2> /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > conjur-conjur.pem
# execute the ansible-playbook wrapped around summon to get the secrets
summon bash -c "ansible-playbook -i ./hosts --private-key=\$SSH_KEY cyberark-create-and-onboard-unix.yml"
