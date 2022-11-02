module Deletable
  extend ::ActiveSupport::Concern

  included do
    scope :not_deleted, -> { where(deleted_at: nil) }

    def soft_deleted?
      try(:deleted_at).present?
    end

    def soft_delete!
      raise "Unable to soft delete record" unless respond_to? :deleted_at=

      @deleting_at = Time.now

      try(:deleted_at=, @deleting_at)
      save(validate: false)

      self
    end
  end
end
