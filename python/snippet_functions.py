import subprocess

def get_jira_summary(ticketId, snip):
    if ticketId:
        jira_cmdline_app  = snip.opt("g:jira_cmdline_app", "")
        jira_server       = snip.opt("g:jira_server", "")
        jira_username     = snip.opt("g:jira_username", "")
        jira_password     = snip.opt("g:jira_password", "")

        p = subprocess.Popen( [ jira_cmdline_app,
                "-s",
                jira_server,
                "-u",
                jira_username,
                "-p",
                jira_password,
                "-a",
                "getFieldValue",
                "--field",
                "Summary",
                "--issue",
                ticketId],
                stdin=subprocess.PIPE,
                stdout=subprocess.PIPE, 
                stderr=subprocess.PIPE)

        out, err = p.communicate()

        if p.returncode != 0:
            return "ERROR!\n" + err

        lines = out.split("\n")

        # remove the first line "Issue xxx has field 'Summary' with value"
        if len( lines ) > 1:
            lines.pop(0)
            return "\n".join(lines).rstrip()

    return ""

def complete_from_list(value, opts):
    result = [opt[len(value):] for opt in opts if opt.startswith(value)]

    if len(result) == 0:
        return "{!" + "|".join(opts) + "!}"
    elif len(result) == 1:
        return result[0]
    else:
        return "{" + "|".join(result) + "}"
