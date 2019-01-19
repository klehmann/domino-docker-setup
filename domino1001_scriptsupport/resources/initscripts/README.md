Customized Docker entrypoint script, copied from Daniel Nashed's start/stop scripts.
Changed so that the script stops after the initial setup so that we have time to copy the id files and can start the server without passwords in the environment.
