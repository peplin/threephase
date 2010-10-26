def stub_time
  time = Time.now
  Time.stubs(:now).returns(time)
end
