impl :: bincode :: Encode for FrecencyEntry
{
    fn encode < __E : :: bincode :: enc :: Encoder >
    (& self, encoder : & mut __E) ->core :: result :: Result < (), :: bincode
    :: error :: EncodeError >
    {
        :: bincode :: Encode :: encode(&self.hash, encoder) ?; :: bincode ::
        Encode :: encode(&self.timestamp, encoder) ?; :: bincode :: Encode ::
        encode(&self.score, encoder) ?; core :: result :: Result :: Ok(())
    }
}