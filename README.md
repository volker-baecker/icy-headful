# icy-headful
A docker image to run the image analysis software icy in an x-environment, so that the graphical user interface can be used.

Run with 

	docker run -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v $(pwd):/data mricnrsfr/icy-headful
