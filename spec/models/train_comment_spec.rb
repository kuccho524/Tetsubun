require 'rails_helper'

RSpec.describe 'TrainCommentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { train_comment.valid? }

    let(:user) { create(:user) }
    let!(:train_comment) { build(:train_comment, user_id: user.id) }

    context 'commentカラム' do
      it '空欄でないこと' do
        train_comment.comment = ''
        is_expected.to eq false
      end
      it '140文字以下であること: 140文字は〇' do
        train_comment.comment = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
      it '141文字以下であること: 141文字は×' do
        train_comment.comment = Faker::Lorem.characters(number: 141)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(TrainComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Trainモデルとの関係' do
      it 'N:1となっている' do
        expect(TrainComment.reflect_on_association(:train).macro).to eq :belongs_to
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(TrainComment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
