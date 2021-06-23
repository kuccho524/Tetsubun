require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '7文字以下であること: 7文字は〇' do
        user.name = Faker::Lorem.characters(number: 7)
        is_expected.to eq true
      end
      it '7文字以下であること: 8文字は×' do
        user.name = Faker::Lorem.characters(number: 8)
        is_expected.to eq false
      end
      it '一意性があること' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '50文字以下であること: 50文字は〇' do
        user.introduction = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること: 51文字は×' do
        user.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Trainモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:trains).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'TrainCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:train_comments).macro).to eq :has_many
      end
    end

    context '中間モデルPassiveOfRelationshipsとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:passive_of_relationships).macro).to eq :has_many
      end
    end

    context '中間モデルRelationshipsとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
    end

    context '中間モデルFollowersとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end
    end

    context '中間モデルFollowingsとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end
    end

    context 'Messageモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end
    end

    context 'Entryモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context 'Roomモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:rooms).macro).to eq :has_many
      end
    end

    context '中間モデルAcitiveNotificationsとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
    end

    context '中間モデルPassiveNotificationsとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end
end
