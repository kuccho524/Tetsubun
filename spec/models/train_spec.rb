require 'rails_helper'

RSpec.describe 'Trainモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { train.valid? }

    let(:user) { create(:user) }
    let!(:train) { build(:train, user_id: user.id) }

    context 'bodyカラム' do
      it '空欄でないこと' do
        train.body = ''
        is_expected.to eq false
      end
      it '3文字以上であること: 3文字は◯' do
        train.body = Faker::Lorem.characters(number: 3)
      end
      it '50文字以下であること: 50文字は◯' do
        train.body = Faker::Lorem.characters(number: 50)
      end
      it '3文字以上であること: 2文字は×' do
        train.body = Faker::Lorem.characters(number: 2)
        is_expected.to eq false
      end
      it '50文字以下であること: 51文字は×' do
        train.body = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'train_imageカラム' do
      it '空欄でないこと' do
        train.train_image = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Train.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Train.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'TrainCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Train.reflect_on_association(:train_comments).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Train.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
