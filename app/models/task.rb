class Task < ApplicationRecord
    def status
    end
    validates :status, presence: true, length: { maximum: 10 }
end

