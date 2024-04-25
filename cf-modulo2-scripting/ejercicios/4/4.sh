#!/bin/bash

# Enviar un mensaje de notificación a un canal de Slack usando una webhook
# WEBHOOK_URL="https://hooks.slack.com/services/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"
WEBHOOK_URL="https://discord.com/api/webhooks/1154865920741752872/au1jkQ7v9LgQJ131qFnFqP-WWehD40poZJXRGEYUDErXHLQJ_BBszUFtVj8g3pu9bm7h"
MENSAJE="¡Operación completada con éxito! (Lo siento Ross por usar tu boot, averiguare como crear el mio)"
curl -X POST -H 'Content-type: application/json' --data "{\"content\":\"$MENSAJE\"}" $WEBHOOK_URL
