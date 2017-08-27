"""
Backs up and restores a settings file to Dropbox.
This is an example app for API v2.
"""

import sys
import argparse
import dropbox
from dropbox.files import WriteMode
from dropbox.exceptions import ApiError, AuthError

parser = argparse.ArgumentParser()
parser.add_argument('--mode', nargs='?', default='Backup',
                    help='Backup or Restore')
parser.add_argument('--filename', nargs='?',
                    help='File name')


# Add OAuth2 access token here.
# You can generate one for yourself in the App Console.
# See <https://blogs.dropbox.com/developers/2014/05/generate-an-access-token-for-your-own-account/>
TOKEN = 'WcdCa0L5S5AAAAAAAAAAMHGEfNpsuSyhV5J6zFkVdZbowTZiCa5bLzM3BvNDGSpw'

# Uploads contents of FILE_NAME to Dropbox
def backup():
    with open(FILE_NAME, 'rb') as f:
        # We use WriteMode=overwrite to make sure that the settings in the file
        # are changed on upload
        print("Uploading " + FILE_NAME + " to Dropbox as " + FILE_NAME + "...")
        try:
            dbx.files_upload(f.read(), "/"+FILE_NAME, mode=WriteMode('overwrite'))
        except ApiError as err:
            # This checks for the specific error where a user doesn't have
            # enough Dropbox space quota to upload this file
            if (err.error.is_path() and
                    err.error.get_path().error.is_insufficient_space()):
                sys.exit("ERROR: Cannot back up; insufficient space.")
            elif err.user_message_text:
                print(err.user_message_text)
                sys.exit()
            else:
                print(err)
                sys.exit()

# Restore the local and Dropbox files to a certain revision
def restore(rev=None):
    # Restore the file on Dropbox to a certain revision
    print("Restoring " + FILE_NAME + " to revision " + rev + " on Dropbox...")
    dbx.files_restore("/"+FILE_NAME, rev)

    # Download the specific revision of the file at FILE_NAME to FILE_NAME
    print("Downloading current " + FILE_NAME + " from Dropbox, overwriting " + FILE_NAME + "...")
    dbx.files_download_to_file(FILE_NAME, "/"+FILE_NAME, rev)

# Look at all of the available revisions on Dropbox, and return the oldest one
def select_revision():
    # Get the revisions for a file (and sort by the datetime object, "server_modified")
    print("Finding available revisions on Dropbox...")
    entries = dbx.files_list_revisions("/"+FILE_NAME, limit=30).entries
    revisions = sorted(entries, key=lambda entry: entry.server_modified)

    for revision in revisions:
        print(revision.rev, revision.server_modified)

    # Return the oldest revision (first entry, because revisions was sorted oldest:newest)
    return revisions[0].rev

if __name__ == '__main__':
    # Check for an access token
    args = parser.parse_args()
    if (len(TOKEN) == 0):
        sys.exit("ERROR: Looks like you didn't add your access token. "
            "Open up backup-and-restore-example.py in a text editor and "
            "paste in your token in line 14.")
        
    # Create an instance of a Dropbox class, which can make requests to the API.
    print("Creating a Dropbox object...")
    dbx = dropbox.Dropbox(TOKEN)

    # Check that the access token is valid
    try:
        dbx.users_get_current_account()
    except AuthError as err:
        sys.exit("ERROR: Invalid access token; try re-generating an "
            "access token from the app console on the web.")

    # Create a backup of the current settings file
    FILE_NAME = args.filename
    if args.mode == 'Backup':
        backup()
    else:
        to_rev = select_revision()
        restore(to_rev)
    
    print("Done!")
