require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'associations' do
    it { should have_many(:microposts).dependent(:destroy) }
    it { should have_many(:active_relationships).class_name('Relationship').with_foreign_key('follower_id').dependent(:destroy) }
    it { should have_many(:passive_relationships).class_name('Relationship').with_foreign_key('followed_id').dependent(:destroy) }
    it { should have_many(:following).through(:active_relationships).source(:followed) }
    it { should have_many(:followers).through(:passive_relationships).source(:follower) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe '#follow' do
    it 'follows another user' do
      expect { user.follow(other_user) }.to change { user.following.count }.by(1)
    end

    it 'does not follow the same user twice' do
      user.follow(other_user)
      expect { user.follow(other_user) }.not_to change { user.following.count }
    end

    it 'does not follow itself' do
      expect { user.follow(user) }.not_to change { user.following.count }
    end
  end

  describe '#unfollow' do
    before { user.follow(other_user) }

    it 'unfollows a followed user' do
      expect { user.unfollow(other_user) }.to change { user.following.count }.by(-1)
    end

    it 'does nothing if not following the user' do
      expect { user.unfollow(create(:user)) }.not_to change { user.following.count }
    end
  end

  describe '#following?' do
    it 'returns true if following the user' do
      user.follow(other_user)
      expect(user.following?(other_user)).to be(true)
    end

    it 'returns false if not following the user' do
      expect(user.following?(other_user)).to be(false)
    end
  end

  describe '#feed' do
    let(:third_user) { create(:user) }
    let!(:micropost_from_user) { create(:micropost, user: user) }
    let!(:micropost_from_followed) { create(:micropost, user: other_user) }
    let!(:micropost_not_from_followed) { create(:micropost, user: third_user) }

    before { user.follow(other_user) }

    it 'includes microposts from self' do
      expect(user.feed).to include(micropost_from_user)
    end

    it 'includes microposts from followed user' do
      expect(user.feed).to include(micropost_from_followed)
    end

    it 'does not include microposts from unfollowed user' do
      expect(user.feed).not_to include(micropost_not_from_followed)
    end
  end
end
