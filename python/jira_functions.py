# workaround hack for some weird problem with jira, current subprocess and vim launched from the commandline
import os
os.environ['BRANCH_NAME'] = 'release'

from jira import JIRA
from jira.exceptions import JIRAError

import requests
requests.packages.urllib3.disable_warnings()

def get_jira_summary(server, username, password, ticketId):
    try:
        jira = JIRA(server=server, basic_auth=(username, password), options={'verify':False})

        issue = jira.issue(ticketId, fields='summary')

        return issue.fields.summary
    except JIRAError, e:
        return "JIRA error: " + e.text

def post_jira_comment(server, username, password, ticketId, commentText):
    jira = JIRA(server=server, basic_auth=(username, password), options={'verify':False})

    jira.add_comment(ticketId, commentText)
