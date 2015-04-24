#!/bin/bash
echo "------ Create database tables ------"
python manage.py migrate --noinput
python manage.py load_agency_contacts
python manage.py loaddata docusearch.json
echo "------ Haystack tables ------"
python manage.py rebuild_index --noinput
waitress-serve --port=$VCAP_APP_PORT foia_hub.wsgi:application

