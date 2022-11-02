class ApplicationQuery
  def self.query(**args)
    new(**args).send(:query)
  end
end
