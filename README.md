ios-avplayer-http-capture
=========================

iOS based application that embeds the AVPlayer and capture HTTP headers and send it back to the iOS application.  It internally embeds a proxy server.


Introduction
============

This application is a working example of how to capture HTTP traffic generated by AVPlayer.  This is done thru a local proxy hosted on the iOS device itself.

For example, the local proxy is bounded to port 8080, and we configure the reverse_proxy_host to "www.apple.com" and reverse_proxy_port to "80".

Hence, if there's an asset that lives in http://www.apple.com/something.m3u8, we would actually tell the AVPlayer to play the URL http://localhost:8080/something.m3u8

In this case, AVPlayer will talk to the internal proxy server, which would then open a request to www.apple.com.


Usage
=====

To use this, simply modify the file realjkAppDelegate.m and put in your desired parameters:

    [mongooseDaemon startMongooseDaemon:@"8080"           // local proxy port
                                       :@"www.apple.com"  // remote host
                                       :@"80"];           // remote port


Log Format
==========

The log format that is being sent back is of the form:

    [http_code] response_time - request_url


About the Proxy
===============

This application utilizes the Mongoose web server, and we simply modified it such that requests are proxied out (see git revisions).


About the Logs
==============

The HTTP transactions are sent via log messages from the Mongoose web server (native C) via ASL.  To better integrate the data to your application, simply modify the mongoose.c and MongooseDaemon.c to return those information to your application.


