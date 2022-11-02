class ApplicationService
  def self.execute(**args)
    new(**args).send(:execute)
  end
end
