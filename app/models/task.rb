class Task < ApplicationRecord
    def status
    end
    validates :content, presence: true, length: { maximum: 10 }
    validates :status, presence: true, length: { maximum: 10 }
end

