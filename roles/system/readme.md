# system

## note

consider automating caching zypper downloads every 2 hours to crontab

```bash
0 */2 * * * /usr/bin/zypper ref && /usr/bin/zypper --non-interactive dup --download-only --auto-agree-with-licenses >/dev/null 2>&1
```
