#!/usr/local/bin/macruby
# -*- coding: utf-8 -*-
# Captures a photo using iSight.
# Copied from Gist: https://gist.github.com/Watson1978/635013/
framework "Cocoa"
framework "QTKit"

module Gists
  class ISightCapture
  
    def initialize()
      @app = NSApplication.sharedApplication
      @delegate = Capture.new
      @app.delegate = @delegate
    end

    def capture(filename = nil)
      options = {}
      options[:output] = filename
      options[:output] ||= "output/#{Time.now.strftime('%Y-%m-%dT%H-%M-%S')}.jpg"
      @delegate.options = options
      @app.run
    end
  end
  
  class Capture
    attr_accessor :capture_view, :options
  
    def initialize()
      rect = [50, 50, 400, 300]
      win = NSWindow.alloc.initWithContentRect(rect,
                                               styleMask:NSBorderlessWindowMask,
                                               backing:2,
                                               defer:0)
      @capture_view = QTCaptureView.alloc.init
  
      @session = QTCaptureSession.alloc.init
      win.contentView = @capture_view
  
      device = QTCaptureDevice.defaultInputDeviceWithMediaType(QTMediaTypeVideo)
      ret = device.open(nil)
      raise "Device open error." if(ret != true)
  
      input = QTCaptureDeviceInput.alloc.initWithDevice(device)
      @session.addInput(input, error:nil)
  
      @capture_view.captureSession = @session
      @capture_view.delegate = self
  
      @session.startRunning
    end
  
    def view(view, willDisplayImage:image)
      if(@flag == nil)
        @flag = true
        save(image)
        NSApplication.sharedApplication.terminate(nil)
      end
  
      return image
    end
  
    def save(image)
      bitmapRep = NSBitmapImageRep.alloc.initWithCIImage(image)
      blob = bitmapRep.representationUsingType(NSJPEGFileType, properties:nil)
      blob.writeToFile(@options[:output], atomically:true)
    end
  end
end
