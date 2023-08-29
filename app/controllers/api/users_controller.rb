require 'eth'

module Api

  class UsersController < ApplicationController
    before_action :log_response_headers

    def log_response_headers
      Rails.logger.info("Response Headers: #{response.headers}")
    end

    def create_or_fetch
      user = User.find_or_create_by(wallet_address: params[:wallet_address])
      user.update(has_required_nft: params[:has_required_nft], avatar: params[:avatar])
      render json: user
    end


    # Endpoint to generate nonce
    def nonce
      # Generate a random nonce
      puts('inside the nonce function')

      nonce = SecureRandom.hex(16)
      # Store the nonce in session or database for later verification
      # cookies[:nonce] = {
      #   value: nonce,
      #   httponly: true,
      #   secure: Rails.env.production?, # Set to true in production
      #   same_site: "None", # Set to :none for cross-site cookies
      # }

      #puts("NONCE in session nonce 2: #{cookies[:nonce]}")

      session[:nonce] = nonce

      puts("Session ID in nonce: #{session.id}")
      puts("NONCE in session nonce 2: #{session[:nonce]}")
      puts("NONCE in session nonce 3: #{nonce}")
      render json: { nonce: nonce }
    end


    # Endpoint to verify the signature
    def verify
      # Retrieve the nonce from session or database
      nonce = session[:nonce]
      message = params[:message]
      signature = params[:signature]
      address = message["address"]
      puts("Session ID in verify: #{session.id}")

      puts("Entire session data: #{session[:nonce]}")
      puts("NONCE in verify: #{nonce}")
      puts("MESSAGE in verify: #{message}")
      puts("SIGNATURE in verify: #{signature}")
      puts("ADDRESS in verify: #{address}")
      # Verify the signature using Ethereum libraries (e.g., eth-sig-util in JS)
      # You might need a Ruby gem or library to verify Ethereum signatures
      is_valid = verify_signature(message, signature, address, nonce)

      if is_valid
        # Handle successful authentication, e.g., create a session or JWT
        render json: { status: 'authenticated' }
      else
        render json: { status: 'unauthenticated' }, status: :unauthorized
      end
    end

    # Endpoint to handle logout
    def logout
      # Clear the session or invalidate the JWT
      reset_session
      render json: { status: 'logged_out' }
    end

    def check_auth_status
      if session[:user_id] # Assuming you store user_id in session after successful authentication
        render json: { isAuthenticated: true }
      else
        render json: { isAuthenticated: false }
      end
    end

    private


    def verify_signature(message, signature, address, nonce)
      # Convert the message to its keccak256 hash
      msg_hash = Eth::Util.keccak256(message.to_json)
      puts("msg hash in verify signature: #{msg_hash}")

      # Recover the public key from the signature
      public_key = Eth::Signature.recover(msg_hash, signature)
      puts("public key in verify signature: #{public_key}")

      # Convert the public key to an Ethereum address
      recovered_address = Eth::Util.public_key_to_address(public_key)
      puts(" recovered address in verify signature: #{recovered_address}")
      puts("address in verify signature: #{address}")

      # Check if the recovered address matches the provided address
      recovered_address.to_s.downcase == address.downcase
    end


  end
end
