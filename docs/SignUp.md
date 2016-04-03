# User inputs:
* E-mail *
* Password *
* Password confirmation *
* Accept terms *

\* Mandatory fields

# Process:
* Insert the member
* Generate a signup token (this is to prevent the member is activated by another user, we make sure the only person who have the token to activate is the one who have access to the email) (later implement to send a code by phone number)
* Send an email to the member with the token and a link to activate
 
 ## When the member clicks on the link to activate:
 * Check if token exists
 * Activate the member
 * Redirect the user to invitation view

**Insert here a class diagram**