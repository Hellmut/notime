#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <syslog.h>
FILE * fp;

static void deinit_daemon()
{
    fclose(fp);
}

static void init_daemon()
{
    pid_t pid;

    /* Fork off the parent process */
    pid = fork();

    /* An error occurred */
    if (pid < 0)
        exit(EXIT_FAILURE);

    /* Success: Let the parent terminate */
    if (pid > 0)
        exit(EXIT_SUCCESS);

    /* On success: The child process becomes session leader */
    if (setsid() < 0)
        exit(EXIT_FAILURE);

    /* Set new file permissions */
    umask(0);

    /* Change the working directory to the root directory */
    /* or another appropriated directory */
    chdir("/");

    /* Close stdin. stdout and stderr */
    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);

    /* Open the log file */
    fp = fopen("/root/Log.txt", "w+");
}

int main()
{
    init_daemon();

    while (1)
    {
        sleep (60);
        system("/etc/notime/notime.sh /etc/notime/host_internet_addr.conf");
        // break;
    }

    fprintf(fp, "First daemon terminated.\n");
    deinit_daemon();

    return EXIT_SUCCESS;
}
