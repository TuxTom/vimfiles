from jira_functions import get_jira_summary

def snip_get_jira_summary(ticketId, snip):
    if ticketId:
        jira_server       = snip.opt("g:jira_server", "")
        jira_username     = snip.opt("g:jira_username", "")
        jira_password     = snip.opt("g:jira_password", "")

        return get_jira_summary(jira_server, jira_username, jira_password, ticketId)

    return ""

def snip_complete_from_list(value, opts):
    result = [opt[len(value):] for opt in opts if opt.startswith(value)]

    if len(result) == 0:
        return "{!" + "|".join(opts) + "!}"
    elif len(result) == 1:
        return result[0]
    else:
        return "{" + "|".join(result) + "}"
