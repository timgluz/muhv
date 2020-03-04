module Functions
  # example function to expose heart beat
  class Health < BaseDryFunction
    def call
      M::Success(
        health: 'Feeling Good!'
      )
    end
  end
end
