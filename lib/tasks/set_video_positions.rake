desc "Set all videos without postions to 0"
task :video_position_cleanup => :environment do

  Video.all.each do |video|
    video.position = 0 unless video.postion
  end
end
