RSpec.describe User, type: :model do
  it { should have_many(:identities).dependent(:destroy) }
  it { should have_many(:publishes).dependent(:destroy) }
  it { should have_one(:site).dependent(:destroy) }
  it { should have_one(:vk_group).dependent(:destroy) }
  it { should have_many(:albums).through(:vk_group) }
  it { should validate_presence_of :role }
  it { should validate_inclusion_of(:role).in_array(%w[user admin]) }

  it 'should be valid' do
    user = create :user

    expect(user).to be_valid
  end

  it 'should be valid with email and password' do
    user = User.new email: 'example@gmail.com', password: 'password'

    expect(user).to be_valid
  end

  it 'should be invalid without email' do
    user = User.new email: nil
    user.valid?

    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'should be invalid without password' do
    user = User.new password: nil
    user.valid?

    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'should be invalid with a duplicate email' do
    User.create email: 'example@gmail.com', password: 'password'
    user = User.new email: 'example@gmail.com', password: 'password'
    user.valid?

    expect(user.errors[:email]).to include('has already been taken')
  end

  describe 'callbacks' do
    context 'create_sites_objects' do
      it 'should create new vk_group for user' do
        expect { create :user }.to change(VkGroup, :count).by(1)
      end

      it 'should create new site for user' do
        expect { create :user }.to change(Site, :count).by(1)
      end
    end
  end

  describe 'methods' do
    context '.find_for_oauth' do
      let(:oauth) { create :oauth, :with_credentials }

      context 'for unexisted user and identity' do
        it 'creates new User' do
          expect { User.find_for_oauth(oauth) }.to change(User, :count).by(1)
        end

        it 'returns new User' do
          expect(User.find_for_oauth(oauth)).to eq User.last
        end

        it 'creates new Identity' do
          expect { User.find_for_oauth(oauth) }.to change(Identity, :count).by(1)
        end

        it 'new Identity has params from oauth and belongs to new User' do
          user = User.find_for_oauth(oauth)
          identity = Identity.last

          expect(identity.uid).to eq oauth.uid
          expect(identity.provider).to eq oauth.provider
          expect(identity.user).to eq user
        end
      end

      context 'for existed user without identity' do
        let!(:user) { create :user, email: oauth.info[:email] }

        it 'does not create new User' do
          expect { User.find_for_oauth(oauth) }.to_not change(User, :count)
        end

        it 'returns existed user' do
          expect(User.find_for_oauth(oauth)).to eq user
        end

        it 'creates new Identity' do
          expect { User.find_for_oauth(oauth) }.to change(Identity, :count).by(1)
        end

        it 'new Identity has params from oauth and belongs to existed user' do
          User.find_for_oauth(oauth)
          identity = Identity.last

          expect(identity.uid).to eq oauth.uid
          expect(identity.provider).to eq oauth.provider
          expect(identity.user).to eq user
        end
      end

      context 'for existed user with identity' do
        let!(:user) { create :user, email: oauth.info[:email] }
        let!(:identity) { create :identity, uid: oauth.uid, user: user }

        it 'does not create new User' do
          expect { User.find_for_oauth(oauth) }.to_not change(User, :count)
        end

        it 'returns existed user' do
          expect(User.find_for_oauth(oauth)).to eq user
        end

        it 'does not create new Identity' do
          expect { User.find_for_oauth(oauth) }.to_not change(Identity, :count)
        end
      end
    end

    context '.admin?' do
      it 'should return true if user is admin' do
        user = create :user, :admin

        expect(user.admin?).to eq true
      end

      it 'should return false if user is not admin' do
        user = create :user

        expect(user.admin?).to eq false
      end
    end

    context '.with_albums?' do
      let!(:user) { create :user }

      context 'without albums' do
        it 'returns false' do
          expect(user.with_albums?).to eq false
        end
      end

      context 'with albums' do
        let!(:album_1) { create :album, name: 'Базовая коллекция', vk_group: user.vk_group }
        let!(:album_2) { create :album, name: 'Коллекция Весна-Лето', vk_group: user.vk_group }
        let!(:album_3) { create :album, name: 'Коллекция Остатки сладки', vk_group: user.vk_group }

        it 'returns true' do
          expect(user.with_albums?).to eq true
        end
      end
    end

    context '.with_valid_token?' do
      let!(:user) { create :user }

      it 'returns true for updated users' do
        user.update(token: '123')
        user.reload

        expect(user.with_valid_token?).to eq true
      end
    end
  end
end
