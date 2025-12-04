impl < __Context > :: bincode :: Decode < __Context > for FrecencyEntry
{
    fn decode < __D : :: bincode :: de :: Decoder < Context = __Context > >
    (decoder : & mut __D) ->core :: result :: Result < Self, :: bincode ::
    error :: DecodeError >
    {
        core :: result :: Result ::
        Ok(Self
        {
            hash : :: bincode :: Decode :: decode(decoder) ?, timestamp : ::
            bincode :: Decode :: decode(decoder) ?, score : :: bincode ::
            Decode :: decode(decoder) ?,
        })
    }
} impl < '__de, __Context > :: bincode :: BorrowDecode < '__de, __Context >
for FrecencyEntry
{
    fn borrow_decode < __D : :: bincode :: de :: BorrowDecoder < '__de,
    Context = __Context > > (decoder : & mut __D) ->core :: result :: Result <
    Self, :: bincode :: error :: DecodeError >
    {
        core :: result :: Result ::
        Ok(Self
        {
            hash : :: bincode :: BorrowDecode ::< '_, __Context >::
            borrow_decode(decoder) ?, timestamp : :: bincode :: BorrowDecode
            ::< '_, __Context >:: borrow_decode(decoder) ?, score : :: bincode
            :: BorrowDecode ::< '_, __Context >:: borrow_decode(decoder) ?,
        })
    }
}