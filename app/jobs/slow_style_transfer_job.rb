class SlowStyleTransferJob < ApplicationJob
  queue_as :style_transfers

  require 'open3'

	def perform(transfer, nst)
		nst.update(status: "processing")
	  	Open3.popen3(transfer) do |stdin, stdout, stderr, wait_thr|
	    	@progress = -50
	    	@progresspercent = 0
	    	@progressstep = 1
		 	stdout.each do |line|
		  		@progressprevious = @progress
		  		@progresspercentprevious = @progresspercent
		  		@progressstepprevious = @progressstep
		  		@progress += 1
		  		@progresspercent = @progress / ( nst.iterations / 100 )
		  		if @progresspercent != @progresspercentprevious

		  			if @progress > ( 100 * @progressstepprevious )
		  				@progressimage = (@progressstep * 100)
		  				nst.update(outputImage: "/nst-output/nst-#{nst.id}_#{@progressimage}.jpg")
		  				@progressstep += 1
		  			end


		  		end
		  		print @progresspercent.to_s + "\n"

		  	end
			@return_value = wait_thr.value
			if stderr then
				nst.update(status: "error")
			end
		end
		if @return_value.success?
			nst.update(outputImage: "/nst-output/nst-#{nst.id}_#{nst.iterations}.jpg")
			nst.update(status: "success")
		end
	end
end
