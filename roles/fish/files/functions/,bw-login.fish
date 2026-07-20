function ,bw-login --description "Log in to Bitwarden CLI using API key from macOS Keychain"
    set -l client_id (security find-generic-password -a "$USER" -s bw-clientid -w)
    or return $status

    set -l client_secret (security find-generic-password -a "$USER" -s bw-clientsecret -w)
    or return $status

    env BW_CLIENTID="$client_id" BW_CLIENTSECRET="$client_secret" bw login --apikey
end
